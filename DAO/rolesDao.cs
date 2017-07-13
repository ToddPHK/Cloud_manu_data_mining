//添加必要的动态连接库
using Model;
using DBUtility;
using System.Collections.Generic;


/*******************************************
 * 联系: Allen                             *
 * QQ  : 834308166                         *
 * Email:cqniit@126.com                    *
 * Web :http://cqsoft.taobao.com           *
 *******************************************/
 namespace DAO
{
    public class rolesDao
    {

        public bool Add_roles(roles roles)
        {
            if (DbHelperSQL.Insert(roles))
                return true;
            else
                return false;
        }
        public bool Del_roles(roles roles)
        {
            if (DbHelperSQL.Delete(roles))
                return true;
            else
                return false;
        }
        public bool Update_roles(roles roles)
        {
            if (DbHelperSQL.Update(roles))
                return true;
            else
                return false;
        }
        public roles FindById_roles(int id)
        {
            roles model = new roles();
            return Common<roles>.Dt2Model(model, DbHelperSQL.FindByConditions(model, "roleid=" + id.ToString()));
        }
        public IList<roles> FindAll_roles()
        {
            return Common<roles>.Dt2List(DbHelperSQL.FindByConditions(3,new roles(),""));
        }
    }
}
