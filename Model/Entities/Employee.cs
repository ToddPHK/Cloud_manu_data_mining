using System;
using System.Collections;


  
namespace Model
{
   public class Employee
   {
      #region 构造函数

      public Employee()
      {}


      public Employee(string EmployeeNumber, string FullName, string Gender, string degree,string MobilePhone, string DepartmentNumber, string Position, string BirthDate, string Address, string Email, string BriefIntroduction, string HireDate)
      {

          this._EmployeeNumber = EmployeeNumber;
          this._FullName = FullName;
          this._Gender = Gender;
          this._degree=degree;
          this._MobilePhone = MobilePhone;
          this._DepartmentNumber = DepartmentNumber;
          this._Position = Position;
          this._BirthDate = BirthDate; 
          this._Address = Address;
          this._Email = Email;
          this._BriefIntroduction = BriefIntroduction;
          this._HireDate = HireDate;

      }
      #endregion

      #region 成员

      private string _EmployeeNumber;
      private string _FullName;
      private string _Gender;
      private string _degree;
      private string _MobilePhone;
      private string _DepartmentNumber;
      private string _Position;
      private string _BirthDate;
      private string _Address; 
      private string _Email;
      private string _BriefIntroduction;
      private string _HireDate;

      #endregion


      #region 属性
      
		/// <summary>员工号</summary>
		public string EmployeeNumber
		{
			get { return _EmployeeNumber ; }
			set { _EmployeeNumber = value ; }
		}

		/// <summary>姓名</summary>
		public string FullName
		{
			get { return _FullName ; }
			set { _FullName = value ; }
		}

		/// <summary>性别</summary>
		public string Gender
		{
			get { return _Gender ; }
			set { _Gender = value ; }
		}


		/// <summary>手机</summary>
		public string MobilePhone
		{
			get { return _MobilePhone ; }
			set { _MobilePhone = value ; }
		}



		/// <summary>部门号</summary>
		public string DepartmentNumber
		{
			get { return _DepartmentNumber ; }
			set { _DepartmentNumber = value ; }
		}

		/// <summary>民族号</summary>
        public string degree 
		{
            get { return _degree; }
            set { _degree = value; }
		}


		/// <summary>职位</summary>
		public string Position
		{
			get { return _Position ; }
			set { _Position = value ; }
		}

		/// <summary>生日</summary>
        public string BirthDate
		{
			get { return _BirthDate ; }
			set { _BirthDate = value ; }
		}

		/// <summary>地址</summary>
		public string Address
		{
			get { return _Address ; }
			set { _Address = value ; }
		}



		/// <summary>简介</summary>
		public string BriefIntroduction
		{
			get { return _BriefIntroduction ; }
			set { _BriefIntroduction = value ; }
		}

        public string HireDate
        {
            get { return _HireDate; }
            set { _HireDate = value; }
        }

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
      #endregion
      
      #region 获得自增键

      private string ReturnAutoID()
      {
          return "EmployeeNumber";
      }

      #endregion
   }
}
