package com.huoping.crm.workbench.service;

import com.huoping.crm.workbench.entity.TblActivity;

/**
 * (TblActivity)表服务接口
 *
 * @author huoping
 * @since 2022-08-07 18:26:44
 */
public interface TblActivityService {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    TblActivity queryById(String id);

    /**
     * 新增数据
     *
     * @param tblActivity 实例对象
     * @return 实例对象
     */
    TblActivity insert(TblActivity tblActivity);

    /**
     * 修改数据
     *
     * @param tblActivity 实例对象
     * @return 实例对象
     */
    TblActivity update(TblActivity tblActivity);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    boolean deleteById(String id);

    /**
     * 新增市场活动
     *
     * @param tblActivity
     * @return
     */
    int insertAcitityData(TblActivity tblActivity);

}
