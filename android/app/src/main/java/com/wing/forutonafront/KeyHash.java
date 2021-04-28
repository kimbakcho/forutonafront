package com.wing.forutonafront;
import android.content.pm.PackageInfo;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;
import android.util.Log;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

class KeyHash {
    public static String GET_KEY_HASH = "getKeyHash";
    public static String printKeyHash(Context context,String packageName)  {
        String keyHash = "";
        PackageInfo info = null;
        try {
            info =  context.getPackageManager().getPackageInfo(packageName, PackageManager.GET_SIGNATURES);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        for (Signature signature :info.signatures) {
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("SHA");
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            md.update(signature.toByteArray());
            String something = new String(Base64.encode(md.digest(), 0));
            Log.i("hash key", something);
            keyHash = something;
        }
        return keyHash;
    }
}
