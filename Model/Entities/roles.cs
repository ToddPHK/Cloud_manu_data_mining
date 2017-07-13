using System;
using System.Collections;



 namespace Model
{
   public class roles
   {
      #region 构造函数
      public roles()
      {}

      public roles(int roleid,string roleno,string rolename,string beizhu)
      {
         this._roleid=roleid;
         this._roleno=roleno;
         this._rolename=rolename;
         this._beizhu=beizhu;
      }
      #endregion

      #region 成员
      private int _roleid;
      private string _roleno;
      private string _rolename;
      private string _beizhu;
      #endregion

      #region 属性
      public  int roleid
      {
         get {  return _roleid; }
         set {  _roleid = value; }
      }

      public  string roleno
      {
         get {  return _roleno; }
         set {  _roleno = value; }
      }

      public  string rolename
      {
         get {  return _rolename; }
         set {  _rolename = value; }
      }

      public  string beizhu
      {
         get {  return _beizhu; }
         set {  _beizhu = value; }
      }

      #endregion

      //返回自动增长的ID
      private string ReturnAutoID()
      {
          return "roleid";
      }
   }
}
