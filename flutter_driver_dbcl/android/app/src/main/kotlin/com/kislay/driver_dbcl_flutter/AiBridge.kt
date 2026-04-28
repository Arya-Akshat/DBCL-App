package com.kislay.driver_dbcl_flutter

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.components.containers.NormalizedLandmark
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarker
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker
import kotlin.math.sqrt

data class AiResult(
    val ear: Float,
    val handNearEar: Boolean,
    val faceVisible: Boolean,
    val embedding: FloatArray? = null
)

class AiBridge(private val context: Context) {

    private var faceLandmarker: FaceLandmarker? = null
    private var handLandmarker: HandLandmarker? = null

    private val LEFT_EYE  = intArrayOf(33, 160, 158, 133, 153, 144)
    private val RIGHT_EYE = intArrayOf(362, 385, 387, 263, 373, 380)
    private val LEFT_EAR_LM  = 234
    private val RIGHT_EAR_LM = 454

    init {
        val faceBaseOptions = BaseOptions.builder()
            .setModelAssetPath("face_landmarker.task")
            .build()
        val faceOptions = FaceLandmarker.FaceLandmarkerOptions.builder()
            .setBaseOptions(faceBaseOptions)
            .setNumFaces(1)
            .setRunningMode(RunningMode.IMAGE)
            .build()
        faceLandmarker = FaceLandmarker.createFromOptions(context, faceOptions)

        val handBaseOptions = BaseOptions.builder()
            .setModelAssetPath("hand_landmarker.task")
            .build()
        val handOptions = HandLandmarker.HandLandmarkerOptions.builder()
            .setBaseOptions(handBaseOptions)
            .setNumHands(1)
            .setRunningMode(RunningMode.IMAGE)
            .build()
        handLandmarker = HandLandmarker.createFromOptions(context, handOptions)

        FaceNetHelper.init(context)
    }

    fun processFrame(y: ByteArray, u: ByteArray, v: ByteArray, width: Int, height: Int, rotation: Int, detectFace: Boolean = false): AiResult {
        val bitmap = yuvToBitmap(y, u, v, width, height)
        val rotated = rotateBitmap(bitmap, rotation.toFloat())
        val mpImage = BitmapImageBuilder(rotated).build()

        val faceResult = faceLandmarker?.detect(mpImage)
        val faceVisible = faceResult != null && faceResult.faceLandmarks().isNotEmpty()

        var ear = 1.0f
        var handNearEar = false
        var embedding: FloatArray? = null

        if (faceVisible) {
            val faceLms = faceResult!!.faceLandmarks()[0]
            ear = calculateEar(faceLms)

            val handResult = handLandmarker?.detect(mpImage)
            if (handResult != null && handResult.landmarks().isNotEmpty()) {
                handNearEar = checkHandNearEar(handResult.landmarks()[0], faceLms)
            }

            if (detectFace) {
                embedding = FaceNetHelper.getEmbedding(rotated)
            }
        }

        return AiResult(ear, handNearEar, faceVisible, embedding)
    }

    private fun yuvToBitmap(y: ByteArray, u: ByteArray, v: ByteArray, width: Int, height: Int): Bitmap {
        val out = IntArray(width * height)
        var i = 0
        for (yIdx in 0 until height) {
            for (xIdx in 0 until width) {
                val uvIdx = (yIdx / 2) * (width / 2) + (xIdx / 2)
                val yp = y[yIdx * width + xIdx].toInt() and 0xff
                val up = u.getOrElse(uvIdx) { 128.toByte() }.toInt() and 0xff
                val vp = v.getOrElse(uvIdx) { 128.toByte() }.toInt() and 0xff
                
                val r = (yp + 1.370705 * (vp - 128)).toInt().coerceIn(0, 255)
                val g = (yp - 0.337633 * (up - 128) - 0.698001 * (vp - 128)).toInt().coerceIn(0, 255)
                val b = (yp + 1.732446 * (up - 128)).toInt().coerceIn(0, 255)
                
                out[i++] = (0xff shl 24) or (r shl 16) or (g shl 8) or b
            }
        }
        return Bitmap.createBitmap(out, width, height, Bitmap.Config.ARGB_8888)
    }

    private fun calculateEar(landmarks: List<NormalizedLandmark>): Float {
        val left  = eyeRatio(landmarks, LEFT_EYE)
        val right = eyeRatio(landmarks, RIGHT_EYE)
        return (left + right) / 2f
    }

    private fun eyeRatio(lm: List<NormalizedLandmark>, idx: IntArray): Float {
        val pts = idx.map { Pair(lm[it].x(), lm[it].y()) }
        val v1 = dist(pts[1], pts[5])
        val v2 = dist(pts[2], pts[4])
        val h  = dist(pts[0], pts[3])
        return if (h < 0.001f) 1.0f else (v1 + v2) / (2f * h)
    }

    private fun checkHandNearEar(handLms: List<NormalizedLandmark>, faceLms: List<NormalizedLandmark>): Boolean {
        val leftEar  = faceLms[LEFT_EAR_LM]
        val rightEar = faceLms[RIGHT_EAR_LM]
        val finger   = handLms[8]
        val dL = dist(Pair(finger.x(), finger.y()), Pair(leftEar.x(), leftEar.y()))
        val dR = dist(Pair(finger.x(), finger.y()), Pair(rightEar.x(), rightEar.y()))
        return dL < 0.15f || dR < 0.15f
    }

    private fun dist(a: Pair<Float, Float>, b: Pair<Float, Float>): Float {
        val dx = a.first - b.first
        val dy = a.second - b.second
        return sqrt(dx * dx + dy * dy)
    }

    private fun rotateBitmap(bitmap: Bitmap, degrees: Float): Bitmap {
        if (degrees == 0f) return bitmap
        val matrix = Matrix().apply { postRotate(degrees) }
        return Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
    }

    fun close() {
        faceLandmarker?.close()
        handLandmarker?.close()
        FaceNetHelper.close()
    }
}
