using System;
using System.Collections;


 namespace Model
{
   public class userinfo
   {
      #region 构造函数
      public userinfo()
      {}

      public userinfo(int userid, string username, string password, int roleid, string telephone, string address, string email, string logintime, string createtime)
      {
          this._userid = userid;
          this._username = username;
          this._password = password;
          this._roleid = roleid;
          this._telephone = telephone;
          this._address = address;
          this._email = email;
          this._logintime = logintime;
          this._createtime = createtime;
      }
      #endregion

      #region 成员
      private int _userid;
      private string _username;
      private string _password;
      private int _roleid;
      private string _telephone;
      private string _address;
      private string _email;
      private string _logintime;
      private string _createtime;
      #endregion


      #region 属性
      public  int userid
      {
         get {  return _userid; }
         set {  _userid = value; }
      }

      public  string username
      {
         get {  return _username; }
         set {  _username = value; }
      }

      public  string password
      {
         get {  return _password; }
         set {  _password = value; }
      }

      public  int roleid
      {
         get {  return _roleid; }
         set {  _roleid = value; }
      }

      public  string telephone
      {
         get {  return _telephone; }
         set {  _telephone = value; }
      }


      public  string address
      {
         get {  return _address; }
         set {  _address = value; }
      }

      public  string email
      {
         get {  return _email; }
         set {  _email = value; }
      }

      public string logintime
      {
         get {  return _logintime; }
         set {  _logintime = value; }
      }

      public string createtime
      {
         get {  return _createtime; }
         set {  _createtime = value; }
      }

      #endregion
      //返回自动增长的ID
      private string ReturnAutoID()
      {
          return "userid";
      }
   }
}
