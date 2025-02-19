import java.util.Properties
import java.io.File
import java.io.FileInputStream
import java.io.FileNotFoundException

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Properties 객체 생성
val dotenv = Properties()

// .env 파일 경로 설정
val envFile = file("${rootProject.projectDir}/../assets/.env")

// .env 파일이 존재하면 로드
if (envFile.exists()) {
    FileInputStream(envFile).use { dotenv.load(it) }
} else {
    throw FileNotFoundException("Could not find .env file at: ${envFile.path}")
}

android {
    namespace = "com.mango.refrigerator"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.mango.refrigerator"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // .env에서 KAKAO_API_KEY 가져오기
        val kakaoKey = dotenv.getProperty("KAKAO_API_KEY")
        if (kakaoKey.isNullOrBlank()) {
            throw FileNotFoundException("KAKAO_NATIVE_APP_KEY not found in .env file")
        }

        manifestPlaceholders["YOUR_NATIVE_APP_KEY"] = kakaoKey
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
