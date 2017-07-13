using System.Collections.Generic;

using Model;
using DAO;


 namespace BLL
{
    public class userinfoMgr
    {
        //一定注意这里的userinfoDao是和Services.xml是对应的，必须相同

        userinfoDao userinfoDao = new userinfoDao();

        public IList<userinfo> FindAllByPage_userinfo(string start, string limit, string conditions)
        {
            return userinfoDao.FindAllByPage_userinfo(start, limit, conditions);
        }
        public string GetCount_userinfo(string conditions)
        {
            return userinfoDao.GetCount_userinfo(conditions);
        }
        public bool Add_userinfo(userinfo userinfo)
        {
            return userinfoDao.Add_userinfo(userinfo);
        }
        public userinfo FindById_userinfo(string id)
        {
            return userinfoDao.FindById_userinfo(id);
        }
        public bool Del_userinfo(userinfo userinfo)
        {
            return userinfoDao.Del_userinfo(userinfo);
        }
        public bool Update_userinfo(userinfo userinfo)
        {
            return userinfoDao.Update_userinfo(userinfo);
        }
        public IList<userinfo> FindAll_userinfo()
        {
            return userinfoDao.FindAll_userinfo("");
        }
        public userinfo FindById_userinfo(int id)
        {
            return userinfoDao.FindById_userinfo(id);
        }
    }
}
