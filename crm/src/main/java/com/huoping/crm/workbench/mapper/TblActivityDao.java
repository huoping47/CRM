package com.huoping.crm.workbench.mapper;

import com.huoping.crm.workbench.entity.TblActivity;
import org.apache.ibatis.annotations.Param;

import java.awt.print.Pageable;
import java.util.List;
import java.util.Map;

/**
 * (TblActivity)表数据库访问层
 *
 * @author huoping
 * @since 2022-08-07 18:24:54
 */
public interface TblActivityDao {

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    TblActivity queryById(String id);

    /**
     * 查询指定行数据
     *
     * @param tblActivity 查询条件
     * @param pageable    分页对象
     * @return 对象列表
     */
    List<TblActivity> queryAllByLimit(TblActivity tblActivity, @Param("pageable") Pageable pageable);

    /**
     * 统计总行数
     *
     * @param tblActivity 查询条件
     * @return 总行数
     */
    long count(TblActivity tblActivity);

    /**
     * 新增数据
     *
     * @param tblActivity 实例对象
     * @return 影响行数
     */
    int insert(TblActivity tblActivity);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<TblActivity> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<TblActivity> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<TblActivity> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<TblActivity> entities);

    /**
     * 修改数据
     *
     * @param tblActivity 实例对象
     * @return 影响行数
     */
    int update(TblActivity tblActivity);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(String id);

    /**
     * 新增市场活动数据
     *
     * @param tblActivity
     * @return
     */
    int insertAcitityData(TblActivity tblActivity);

    /**
     * 查询所有的活动数据
     *
     * @return
     */
    List<TblActivity> selectAllDataActivityForPage(Map<String, Object> map);

    /**
     * 统计市场活动数据的总条数
     */
    int SelectCountAllActivityData(Map<String, Object> map);
}

