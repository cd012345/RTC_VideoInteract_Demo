package com.volcengine.vertcdemo.videochatdemo.bean;

import com.google.gson.annotations.SerializedName;
import com.volcengine.vertcdemo.core.net.rtm.RTMBizInform;

public class MediaChangedBroadcast implements RTMBizInform {

    @SerializedName("mic")
    @VCUserInfo.MicStatus
    public int mic;
    @SerializedName("camera")
    @VCUserInfo.CameraStatus
    public int camera;
    @SerializedName("user_info")
    public VCUserInfo userInfo;

    @Override
    public String toString() {
        return "MediaChangedBroadcast{" +
                "mic=" + mic +
                ", camera=" + camera +
                ", userInfo=" + userInfo +
                '}';
    }
}
