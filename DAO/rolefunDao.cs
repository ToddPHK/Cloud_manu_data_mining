//添加必要的动态连接库
using Model;
using System.Collections.Generic;
using DBUtility;
using System.Data;


namespace DAO
{
    public class rolefunDao
    {

        public bool Add_rolefun(rolefun rolefun)
        {
            if (IsExist(rolefun))
                return true;
            if (DbHelperSQL.Insert(rolefun))
                return true;
            else
                return false;
        }
        public bool IsExist(rolefun rolefun)
        {
            string sql = "select * from rolefun where roleid=" + rolefun.roleid + " and funid=" + rolefun.funid;
            if (DbHelperSQL.Query(sql).Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        public bool DelAllRoleFun(string roleid)
        {
            DbHelperSQL.ExecuteSql("delete from rolefun where roleid=" + roleid);
            return true;
        }
        public bool Del_rolefun(rolefun rolefun)
        {
            if (DbHelperSQL.Delete(rolefun))
                return true;
            else
                return false;
        }
        public bool Update_rolefun(rolefun rolefun)
        {
            if (DbHelperSQL.Update(rolefun))
                return true;
            else
                return false;
        }
        public rolefun FindById_rolefun(int id)
        {
            rolefun model = new rolefun();
            return Common<rolefun>.Dt2Model(model, DbHelperSQL.FindByConditions(model, " pid=" + id.ToString()));
        }
        public IList<rolefun> FindAll_rolefun()
        {
            return Common<rolefun>.Dt2List(DbHelperSQL.FindByConditions(new rolefun(), ""));
        }
        //获得该角色对应的功能模块
        public IList<rolefun> FindFunByRoleId_rolefun(string roleid)
        {
            return Common<rolefun>.Dt2List(DbHelperSQL.FindByConditions(new rolefun(), " roleid='" + roleid + "'"));
        }
        public IList<userfun> FindMyMenu(string roleid)
        {
            if (roleid == "-1") roleid = "1";
            string sql = "select F.funid,F.funno,F.funname,F.fatherid from userfun F,rolefun where rolefun.funid=F.funid and roleid=" + roleid;
            return Common<userfun>.Dt2List(DbHelperSQL.Query(sql).Tables[0]);
        }

        public IList<userfun> FindPaidMenu(int whichDB,string userID)
        {
            string sql = "select privilege from UserInfor where UserID=" + userID;
            DataTable tmpDt = DbHelperSQL.FindTable(whichDB, sql);
            DataTable outDt= new DataTable();
            outDt.Columns.Add("funid", typeof(int));
            outDt.Columns.Add("funno", typeof(string));
            outDt.Columns.Add("funname", typeof(string));
            outDt.Columns.Add("fatherid", typeof(int));
            outDt.Columns.Add("icon",typeof(string));
            string privilege = tmpDt.Rows[0][0].ToString();
            char[] delimiterChars = { ' ', ',', '.', ':', '\t' };
            string[] pFunno = privilege.Split(delimiterChars);
            List<DataRow> drs = new List<DataRow>();
            foreach (string pFun in pFunno)
            {
                sql = "select F.funid,F.funno,F.funname,F.fatherid,F.icon from userfun F where F.funid =" + pFun;
                DataTable dt = DbHelperSQL.FindTable("CloudDW",sql);
                drs.Add(dt.Rows[0]) ;
            }
            DataRow[] rowArray = drs.ToArray();
            foreach (DataRow row in rowArray)
            {
                outDt.ImportRow(row);
            }
            //string sql = "select F.funid,F.funno,F.funname,F.fatherid from userfun F,rolefun where rolefun.funid=F.funid and roleid=" + roleid;
            return Common<userfun>.Dt2List(outDt);
        }

        /// <summary>
        /// Finds my menu.
        /// </summary>
        /// <param name="whichDB">选择执行查询的数据库</param>
        /// <param name="roleid">The roleid.</param>
        /// <returns>IList{userfun}.</returns>
        public IList<userfun> FindMyMenu(int whichDB,string roleid)
        {
            if (roleid == "-1") roleid = "1";
            string sql = "select F.funid,F.funno,F.funname,F.fatherid,F.icon from userfun F,rolefun where rolefun.funid=F.funid and roleid=" + roleid;
            return Common<userfun>.Dt2List(DbHelperSQL.Query(whichDB,sql).Tables[0]);
        }

        public IList<userfun> FindAllMenu(int whichDB, string roleid)
        {
            if (roleid == "-1") roleid = "1";
            string sql = "select F.funid,F.funno,F.funname,F.fatherid,F.icon from userfun F";
            return Common<userfun>.Dt2List(DbHelperSQL.Query(whichDB, sql).Tables[0]);
        }

        //查找只有只读权限（rolep=1）来得到的集合
        public IList<userfun> FindMenuByPermission(string roleid)
        {
            if (roleid == "-1") roleid = "1";
            string sql = "select F.funid,F.funno,F.funname,F.fatherid from userfun F,rolefun where rolefun.funid=F.funid and roleid=" + roleid+" and rolefun.rolep=1";
            return Common<userfun>.Dt2List(DbHelperSQL.Query(sql).Tables[0]);
        }
    }
}
