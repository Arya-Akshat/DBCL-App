package com.kislay.driver_dbcl_flutter

import android.content.Context
import android.graphics.Bitmap
import org.tensorflow.lite.Interpreter
import java.io.FileInputStream
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.channels.FileChannel
import kotlin.math.sqrt

object FaceNetHelper {

    private var interpreter: Interpreter? = null
    private const val INPUT_SIZE = 160
    private const val EMBEDDING_SIZE = 128

    fun init(context: Context) {
        if (interpreter != null) return
        val assetFd = context.assets.openFd("facenet.tflite")
        val inputStream = FileInputStream(assetFd.fileDescriptor)
        val fileChannel = inputStream.channel
        val mappedBuffer = fileChannel.map(
            FileChannel.MapMode.READ_ONLY,
            assetFd.startOffset,
            assetFd.declaredLength
        )
        interpreter = Interpreter(mappedBuffer, Interpreter.Options().apply {
            numThreads = 4
        })
    }

    fun getEmbedding(bitmap: Bitmap): FloatArray {
        val resized = Bitmap.createScaledBitmap(bitmap, INPUT_SIZE, INPUT_SIZE, true)
        val byteBuffer = ByteBuffer.allocateDirect(4 * INPUT_SIZE * INPUT_SIZE * 3)
            .apply { order(ByteOrder.nativeOrder()) }
        val pixels = IntArray(INPUT_SIZE * INPUT_SIZE)
        resized.getPixels(pixels, 0, INPUT_SIZE, 0, 0, INPUT_SIZE, INPUT_SIZE)
        pixels.forEach { pixel ->
            byteBuffer.putFloat(((pixel shr 16 and 0xFF) - 127.5f) / 127.5f)
            byteBuffer.putFloat(((pixel shr 8  and 0xFF) - 127.5f) / 127.5f)
            byteBuffer.putFloat(((pixel         and 0xFF) - 127.5f) / 127.5f)
        }
        val output = Array(1) { FloatArray(EMBEDDING_SIZE) }
        interpreter?.run(byteBuffer, output)
        return normalize(output[0])
    }

    private fun normalize(embedding: FloatArray): FloatArray {
        val norm = sqrt(embedding.map { it * it }.sum())
        return if (norm < 1e-8f) embedding
        else embedding.map { it / norm }.toFloatArray()
    }

    fun euclideanDistance(a: FloatArray, b: FloatArray): Float =
        sqrt(a.zip(b).sumOf { (x, y) -> ((x - y) * (x - y)).toDouble() }.toFloat())

    fun isMatch(a: FloatArray, b: FloatArray): Boolean =
        euclideanDistance(a, b) < 0.9f

    fun serializeEmbedding(embedding: FloatArray): String =
        embedding.joinToString(",")

    fun deserializeEmbedding(str: String): FloatArray {
        return try {
            val cleaned = str.trim().removePrefix("[").removeSuffix("]")
            val parts = cleaned.split(",")
            FloatArray(parts.size) { parts[it].trim().toFloat() }
        } catch (e: Exception) {
            FloatArray(0)
        }
    }

    fun averageEmbeddings(frames: List<FloatArray>): FloatArray {
        if (frames.isEmpty()) return FloatArray(0)
        val result = FloatArray(frames[0].size)
        frames.forEach { frame ->
            frame.forEachIndexed { i, v -> result[i] += v }
        }
        return normalize(result.map { it / frames.size }.toFloatArray())
    }

    fun close() {
        interpreter?.close()
        interpreter = null
    }
}