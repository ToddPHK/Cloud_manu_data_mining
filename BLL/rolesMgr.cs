using System.Collections.Generic;

using Model;
using DAO;


 namespace BLL
{
    public class rolesMgr
    {
        rolesDao rolesDao = new rolesDao();
        public bool Add_roles(roles roles)
        {
            return rolesDao.Add_roles(roles);
        }
        public roles FindById_roles(int id)
        {
            return rolesDao.FindById_roles(id);
        }
        public bool Del_roles(roles roles)
        {
            return rolesDao.Del_roles(roles);
        }
        public bool Update_roles(roles roles)
        {
            return rolesDao.Update_roles(roles);
        }
        public IList<roles> FindAll_roles()
        {
            return rolesDao.FindAll_roles();
        }
    }
}
