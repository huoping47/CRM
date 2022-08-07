package com.huoping.crm.workbench.service.impl;

import com.huoping.crm.workbench.entity.TblActivity;
import com.huoping.crm.workbench.mapper.TblActivityDao;
import com.huoping.crm.workbench.service.TblActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * (TblActivity)表服务实现类
 *
 * @author huoping
 * @since 2022-08-07 18:26:46
 */
@Service("tblActivityService")
public class TblActivityServiceImpl implements TblActivityService {
    @Autowired
    private TblActivityDao tblActivityDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public TblActivity queryById(String id) {
        return this.tblActivityDao.queryById(id);
    }

    /**
     * 新增数据
     *
     * @param tblActivity 实例对象
     * @return 实例对象
     */
    @Override
    public TblActivity insert(TblActivity tblActivity) {
        this.tblActivityDao.insert(tblActivity);
        return tblActivity;
    }

    /**
     * 修改数据
     *
     * @param tblActivity 实例对象
     * @return 实例对象
     */
    @Override
    public TblActivity update(TblActivity tblActivity) {
        this.tblActivityDao.update(tblActivity);
        return this.queryById(tblActivity.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String id) {
        return this.tblActivityDao.deleteById(id) > 0;
    }
}
