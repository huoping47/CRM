package com.huoping.crm.shared.untils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUntil {
    /**
     * 格式化日期        yyyy-MM-dd HH:mm:ss
     *
     * @param dateTime
     * @return
     */
    public static String DateTimeForMatString(Date dateTime) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(dateTime);
    }
}
