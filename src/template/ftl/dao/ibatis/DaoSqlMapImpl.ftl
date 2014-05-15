package ${base_package}.${project_name}.dao.ibatis;

import org.springframework.stereotype.Repository;

import com.ebiz.ssi.dao.ibatis.EntityDaoSqlMapImpl;
import ${base_package}.${project_name}.dao.${dao_name};
import ${base_package}.${project_name}.domain.${domain_name};

<#include "/copyright_java.ftl">
@Repository
public class ${class_name} extends EntityDaoSqlMapImpl<${domain_name}> implements ${dao_name} {

}