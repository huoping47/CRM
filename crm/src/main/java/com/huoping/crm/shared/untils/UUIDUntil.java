package com.huoping.crm.shared.untils;

import java.util.UUID;

public class UUIDUntil {
    public static String getUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
