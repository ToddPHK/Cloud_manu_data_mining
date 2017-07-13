//添加必要的动态连接库
using Model;
using DBUtility;
using System.Collections.Generic;


 namespace DAO
{
    public class userfunDao 
    {

        public bool Add_userfun(userfun userfun)
        {
            if (DbHelperSQL.Insert(userfun))
                return true;
            else
                return false;
        }
        public bool Del_userfun(userfun userfun)
        {
            if (DbHelperSQL.Delete(userfun))
                return true;
            else
                return false;
        }
        public bool Update_userfun(userfun userfun)
        {
            if (DbHelperSQL.Update(userfun))
                return true;
            else
                return false;
        }
        public userfun FindById_userfun(int id)
        {
            userfun model = new userfun();
            return Common<userfun>.Dt2Model(model, DbHelperSQL.FindByConditions(model, "funid=" + id.ToString()));
        }
        public IList<userfun> FindAll_userfun(string strWhere)
        {
            return Common<userfun>.Dt2List(DbHelperSQL.FindByConditions(new userfun(), strWhere));
        }
    }
}
