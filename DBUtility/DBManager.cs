using System;
using System.Data;

namespace DBUtility
{
	/// <summary>
	/// DBManager 的摘要说明。
	/// </summary>
	public interface DBManager
	{
		string _Connstring
		{
			get;
			set;
		}
		string CmdStr
		{
			get;
		}
		IDbConnection OpenConn();
		void CloseConn();
		IDbCommand ExeCommand(string CmdText);
		bool ExecutenonQuery(IDbCommand myComm);
		IDataReader ExecuteCreateReader(IDbCommand myComm);
		IDbDataAdapter ExecuteCreateDataSet(string CmdText);
	}
}
