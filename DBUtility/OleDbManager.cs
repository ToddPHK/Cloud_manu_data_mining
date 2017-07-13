using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace DBUtility
{
	/// <summary>
	/// OleDbManager ��ժҪ˵����
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
		/// OleDbConnection����
		/// </summary>
		/// 
		private OleDbConnection Conn;
		/// <summary>
		/// �����ַ�������
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
		/// ���캯��
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
		//�����ݿ�����
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
		//�ر����ݿ�����
		public void CloseConn()
		{
			Conn.Close();		
			Conn.Dispose();
		}
		//ִ��ExeCommand
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
		//����û�в�����
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
		//����DataReader���ݼ�
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
		//����Adapter���ݼ�
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
