using System;
using System.Collections;



 namespace Model
{
   public class userfun
   {
      #region 构造函数
      public userfun()
      {}

      public userfun(int funid,string funno,string funname,int fatherid,string icon)
      {
         this._funid=funid;
         this._funno=funno;
         this._funname=funname;
         this._fatherid=fatherid;
         this._icon = icon;
      }
      #endregion

      #region 成员
      private int _funid;
      private string _funno;
      private string _funname;
      private int _fatherid;
      private string _icon;
      #endregion


      #region 属性
      public  int funid
      {
         get {  return _funid; }
         set {  _funid = value; }
      }

      public  string funno
      {
         get {  return _funno; }
         set {  _funno = value; }
      }

      public  string funname
      {
         get {  return _funname; }
         set {  _funname = value; }
      }

      public  int fatherid
      {
         get {  return _fatherid; }
         set {  _fatherid = value; }
      }

      public string icon
      {
          get { return _icon; }
          set { _icon = value; }
      }
      #endregion
      //返回自动增长的ID
      private string ReturnAutoID()
      {
          return "funid";
      }
   }
}
