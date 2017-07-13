using System.Collections.Generic;

using Model;
using DAO;


/*******************************************
 * 联系: Allen                             *
 * QQ  : 834308166                         *
 * Email:cqniit@126.com                    *
 * Web :http://cqsoft.taobao.com           *
 *******************************************/
 
 namespace BLL
{
    public class userfunMgr
    {
        userfunDao userfunDao = new userfunDao();
        public bool Add_userfun(userfun userfun)
        {
            return userfunDao.Add_userfun(userfun);
        }
        public userfun FindById_userfun(int id)
        {
            return userfunDao.FindById_userfun(id);
        }
        public bool Del_userfun(userfun userfun)
        {
            return userfunDao.Del_userfun(userfun);
        }
        public bool Update_userfun(userfun userfun)
        {
            return userfunDao.Update_userfun(userfun);
        }
        public IList<userfun> FindAll_userfun()
        {
            return userfunDao.FindAll_userfun("");
        }
    }
}
