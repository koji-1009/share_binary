package com.dr1009.app.share_binary

import androidx.core.content.FileProvider

/**
 * Providing a custom `FileProvider` prevents manifest `<provider>` name collisions.
 *
 * See https://developer.android.com/guide/topics/manifest/provider-element.html for details.
 */
class ShareFileProvider : FileProvider()
