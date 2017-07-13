using Model;
using DBUtility;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;


 namespace DAO
{
    public class userinfoDao 
    {
        public IList<userinfo> FindAllByPage_userinfo(string start, string limit, string conditions)
        {
            string fields = "UserID,userName,userPass as password,roleid,Telephone,Adress as address,eMail,logintime,RegisterTime as createtime";
            //string sql = "select top " + limit + " " + "UserID,userName,userPass as password,roleid,Telephone,Adress as address,eMail,logintime,RegisterTime as createtime"+" from UserInfor";
            //DataTable dt = DbHelperSQL.Query(2, sql).Tables[0];
            return Common<userinfo>.Dt2List(DbHelperSQL.FindFieldsByPage(2, new userinfo(),fields, start, limit, conditions));
            //return Common<userinfo>.Dt2List(dt);
        }
        /// <summary>
        /// 查找符合条件记录的总条数，共分页使用
        /// </summary>
        /// <param name="limit"></param>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public string GetCount_userinfo(string conditions)
        {
            return DbHelperSQL.GetCountByConditions(2, new userinfo(), conditions);
        }
        /// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		    return DbHelperSQL.GetMaxID("userid", "userinfo"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int userid)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from userinfor");
			strSql.Append(" where userid=@userid ");
			SqlParameter[] parameters = {
					new SqlParameter("@userid", SqlDbType.Int,4)};
			parameters[0].Value = userid;
			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public bool Add_userinfo(userinfo model)
		{
            if (DbHelperSQL.Insert(model))
                return true;
            else
                return false;
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
        public bool Update_userinfo(userinfo model)
		{
            if (DbHelperSQL.Update(model))
                return true;
            else
                return false;
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
        public bool Del_userinfo(userinfo userinfo)
		{
            if (DbHelperSQL.Delete(userinfo))
                return true;
            else
                return false;
		}

        /// <summary>
        /// 根据id查找相应的一条记录
        /// </summary>
        /// <param name="id">要查找的ID号</param>
        /// <returns>返回值</returns>
        public userinfo FindById_userinfo(int id)
        {
            userinfo model = new userinfo();
            return Common<userinfo>.Dt2Model(model, DbHelperSQL.FindByConditions(model, " " + Common<object>.GetModelInfo(model)[1] + "=" + id.ToString()));
        }
		/// <summary>
		/// 得到一个对象实体
		/// </summary>
        public userinfo FindById_userinfo(string userid)
		{
            userinfo model = new userinfo();
            DataTable dt=DbHelperSQL.FindByConditions(model, "userName='" + userid + "'");
            if (dt.Rows.Count <= 0)
                return null;
            else
            {
                return Common<userinfo>.Dt2Model(model, dt);
            }
		}
        
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public IList<userinfo> FindAll_userinfo(string strWhere)
		{
			return Common<userinfo>.Dt2List(DbHelperSQL.FindByConditions(new userinfo(),strWhere));
		}


    }
}
