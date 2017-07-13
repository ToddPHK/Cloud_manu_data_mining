using System;
using System.Collections;


 namespace Model
{
   public class rolefun
   {
      #region 构造函数
      public rolefun()
      {}

      public rolefun(int pid,int roleid,int funid,int rolep)
      {
         this._pid=pid;
         this._roleid=roleid;
         this._funid=funid;
         this._rolep=rolep;
      }
      #endregion

      #region 成员
      private int _pid;
      private int _roleid;
      private int _funid;
      private int _rolep;
      #endregion


      #region 属性
      public  int pid
      {
         get {  return _pid; }
         set {  _pid = value; }
      }

      public  int roleid
      {
         get {  return _roleid; }
         set {  _roleid = value; }
      }

      public  int funid
      {
         get {  return _funid; }
         set {  _funid = value; }
      }

      public  int rolep
      {
         get {  return _rolep; }
         set {  _rolep = value; }
      }

      #endregion

      //返回自动增长的ID
      private string ReturnAutoID()
      {
          return "pid";
      }
   }
}
