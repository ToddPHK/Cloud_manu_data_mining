using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace DBUtility
{
	/// <summary>
	/// OleDbManager 的摘要说明。
	/// </summary>
	public class OleDbManager:DBManager
	{
		private string Connstring;
		private string Cmdtext;
		public string CmdStr
		{
			get
			{
				return Cmdtext;
			}
		}
		/// <summary>
		/// OleDbConnection类型
		/// </summary>
		/// 
		private OleDbConnection Conn;
		/// <summary>
		/// 连接字符串属性
		/// </summary>
		public string _Connstring
		{
			get
			{
				return Connstring;
			}
			set
			{
				Connstring=value;
			}
		}
		/// <summary>
		/// 构造函数
		/// </summary>
		/// <param name="StrConn"></param>
		public OleDbManager(string StrConn)
		{
			Connstring = StrConn;
			Conn = new OleDbConnection(StrConn);
		}
		
		//public OleDbManager()
	//	{
	//		Conn= new OleDbConnection(Connstring);
	//	}
		//打开数据库连接
		public IDbConnection OpenConn()
		{
			if(Conn==null)
			{
				Conn = new OleDbConnection(Connstring);
			}
			try
			{
				Conn.Open();
			}
			catch(Exception e)
			{
				throw (e);
			}
			return Conn;
		}
		//关闭数据库连接
		public void CloseConn()
		{
			Conn.Close();		
			Conn.Dispose();
		}
		//执行ExeCommand
		public IDbCommand ExeCommand(string CmdText)
		{
			try
			{
				this.Cmdtext = CmdText;
				return new OleDbCommand(CmdText,Conn);
			}
			catch(Exception e)
			{
				throw (e);
			}
		}
		//返回没有参数的
		public bool ExecutenonQuery(IDbCommand myComm)
		{
			try
			{
				myComm.ExecuteNonQuery();
				return true;
				//myComm.Dispose();
			}
			catch(Exception e)
			{
				throw (e);
			}
			finally
			{
				this.CloseConn();
			}
		}
		//返回DataReader数据集
		public IDataReader ExecuteCreateReader(IDbCommand myComm)
		{
			try
			{
				return myComm.ExecuteReader();
			}
			catch(Exception e)
			{
				throw (e);
				//throw ("error");
			}
			//CommandBehavior.CloseConnection
		}
		//返回Adapter数据集
		public IDbDataAdapter ExecuteCreateDataSet(string CmdText)
		{
			try
			{
				this.Cmdtext = CmdText;
				return  new OleDbDataAdapter(CmdText,Conn);
			}
			catch(Exception e)
			{
				throw (e);
				//throw("error");
			}
		}
	}
}
