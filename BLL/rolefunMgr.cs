using System.Collections.Generic;

using Model;
using DAO;
using Ext.Net;
using System.IO;
using System.Web;
using Ext.Net;


namespace BLL
{
    public class rolefunMgr
    {
        rolefunDao rolefunDao = new rolefunDao();

        public bool Add_rolefun(rolefun rolefun)
        {
            return rolefunDao.Add_rolefun(rolefun);
        }
        public rolefun FindById_rolefun(int id)
        {
            return rolefunDao.FindById_rolefun(id);
        }
        public bool Del_rolefun(rolefun rolefun)
        {
            return rolefunDao.Del_rolefun(rolefun);
        }
        public bool Update_rolefun(rolefun rolefun)
        {
            return rolefunDao.Update_rolefun(rolefun);
        }
        public IList<rolefun> FindAll_rolefun()
        {
            return rolefunDao.FindAll_rolefun();
        }
        public IList<rolefun> GetRoleMenu(string roleid)
        {
            return rolefunDao.FindFunByRoleId_rolefun(roleid);
        }
        public bool DelAllRoleFun(string roleid)
        {
            return rolefunDao.DelAllRoleFun(roleid);
        }
        public IList<userfun> FindRoleFun(string roleid)
        {
            return rolefunDao.FindMyMenu(roleid);
        }
        //根据只读权限来查找集合,并且设置表示层按钮可见性
        public void FindRoleFunByPermission(string roleid, string funname, Button BtnAdd, Button BtnDel, Button BtnSave)
        {
            IList<userfun> user = rolefunDao.FindMenuByPermission(roleid);
            for (int i = 0; i < user.Count; i++)
            {
                if (user[i].funname == funname)
                {
                    BtnAdd.Visible = false;
                    BtnDel.Visible = false;
                    BtnSave.Visible = false;
                }
            }
        }
        //根据只读权限来查找集合,并且设置表示层按钮可见性(多一个导入按钮禁用)
        public void FindRoleFunByPermission2(string roleid, string funname, Button BtnAdd, Button BtnDel, Button BtnSave, Button Button1)
        {
            IList<userfun> user = rolefunDao.FindMenuByPermission(roleid);
            for (int i = 0; i < user.Count; i++)
            {
                if (user[i].funname == funname)
                {
                    BtnAdd.Visible = false;
                    BtnDel.Visible = false;
                    Button1.Visible = false;
                    BtnSave.Visible = false;
                }
            }
        }
        public bool roleFunGive(string funids)
        {
            userfunDao ufundao = new userfunDao();
            string[] funs = funids.Split(',');
            List<userfun> listfun = (List<userfun>)ufundao.FindAll_userfun(" 1=1 ");
            for (int i = 0; i < funs.Length - 1; i++)
            {
                int fatherid = -1;
                int funid = int.Parse(funs[i]);
                while (fatherid != 0)
                {
                    userfun ufun = listfun.Find(delegate(userfun fun) { return fun.funid == funid; });
                    rolefun _rolefun = new rolefun();
                    _rolefun.roleid = int.Parse(funs[funs.Length - 1]);
                    _rolefun.rolep = 0;
                    _rolefun.funid = ufun.funid;
                    rolefunDao.Add_rolefun(_rolefun);
                    funid = ufun.fatherid;
                    fatherid = ufun.fatherid;
                }
            }
            return true;
        }
        /// <summary>
        /// 读取功能树节点.
        /// </summary>
        /// <param name="whichDB">选择获取信息的对象数据库</param>
        /// <param name="roleid">The roleid.</param>
        /// <returns>TreeNodeCollection.</returns>
        public NodeCollection GetMenu(int whichDB, string roleid)
        {
            List<userfun> roleMenu = (List<userfun>)rolefunDao.FindMyMenu(whichDB, roleid); //得到用户所有功能菜单
            List<userfun> userFatherFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid == 0; }); //父节点
            List<userfun> userChildernFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid > 0; }); ;//子节点
            //if (roleid == "-1")
            //  return CreateFunTree(roleid, userFatherFun, userChildernFun);
            return CreateTree(roleid, userFatherFun, userChildernFun);//创建功能树
        }

        public NodeCollection GetAllFun(int whichDB, string roleid)
        {
            List<userfun> roleMenu = (List<userfun>)rolefunDao.FindAllMenu(whichDB, roleid); //得到所有功能菜单
            List<userfun> userFatherFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid == 0; }); //父节点
            List<userfun> userChildernFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid > 0; }); ;//子节点
            if (roleid == "-1")
                return CreateCheckBoxTree(roleid, userFatherFun, userChildernFun);
            return CreateCheckBoxTree(roleid, userFatherFun, userChildernFun);
        }

        public NodeCollection GetPaidFun(int whichDB, string userID)
        {
            List<userfun> roleMenu = (List<userfun>)rolefunDao.FindPaidMenu(whichDB, userID); //得到所有功能菜单
            //List<userfun> userFatherFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid == 0; }); //父节点
            //List<userfun> userChildernFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid > 0; }); ;//子节点
            //if (roleid == "-1")
            //  return CreateCheckBoxTree(roleid, userFatherFun, userChildernFun);
            return CreatePaidNodes(roleMenu);
        }

        public NodeCollection GetMenu(string roleid)
        {
            List<userfun> roleMenu = (List<userfun>)rolefunDao.FindMyMenu(roleid); //得到用户所有功能菜单
            List<userfun> userFatherFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid == 0; }); //父节点
            List<userfun> userChildernFun = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid > 0; }); ;//子节点
            //if (roleid == "-1")
                //return CreateFunTree(roleid, userFatherFun, userChildernFun);
            return CreateTree(roleid, userFatherFun, userChildernFun);
        }
        private NodeCollection CreateTree(string roleid, List<userfun> userFatherFun, List<userfun> userChildernFun)
        {
            NodeCollection nodes = new NodeCollection(false);

            foreach (userfun menu in userFatherFun)
            {
                Node node = new Node();
                //核心
                List<userfun> stack = userChildernFun.FindAll(delegate(userfun fun) { return fun.fatherid == menu.funid; });
                if (stack.Count > 0)
                {//如果为父节点
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    // node.SingleClickExpand = true;
                    node.IconCls = "icon-none";
                    node.Children.AddRange(CreateTree(roleid, stack, userChildernFun));
                }
                else
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    if (File.Exists(HttpContext.Current.Server.MapPath("/images/Icons/" + menu.icon + ".png")))
                        node.IconCls = "icon-" + menu.icon;
                    else
                        node.IconCls = "icon-none";
                    if (menu.fatherid != 0)
                    {
                        node.Href = menu.funno + ".aspx";
                        node.Leaf = true;
                    }                    
                }
                nodes.Add(node);
            }
            return nodes;
        }

        private NodeCollection CreateCheckBoxTree(string roleid, List<userfun> userFatherFun, List<userfun> userChildernFun)
        {
            NodeCollection nodes = new NodeCollection(false);

            foreach (userfun menu in userFatherFun)
            {
                Node node = new Node();
                List<userfun> stack = userChildernFun.FindAll(delegate(userfun fun) { return fun.fatherid == menu.funid; });
                if (stack.Count > 0)
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    // node.SingleClickExpand = true;
                    //node.IconCls = "icon-none";
                    node.Children.AddRange(CreateCheckBoxTree(roleid, stack, userChildernFun));
                }
                else
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    //node.Href = menu.funno + ".aspx";
                    node.Leaf = true;
                    node.Checked = false;
                }
                nodes.Add(node);
            }
            return nodes;
        }

        private NodeCollection CreatePaidNodes(List<userfun> roleMenu)
        {
            NodeCollection nodes = new NodeCollection(false);
            Node paid = new Node();
            paid.NodeID = "paid";
            paid.Text = "已购功能模块";
            paid.Expandable = true;
            //nodes.Add(paid);
            foreach (userfun menu in roleMenu)
            {
                Node node = new Node();
                node.NodeID = menu.funid.ToString();
                node.Text = menu.funname;
                node.Href = menu.funno + ".aspx";
                node.Leaf = true;
                paid.Children.Add(node);
                /*
                List<userfun> stack = roleMenu.FindAll(delegate(userfun fun) { return fun.fatherid == menu.funid; });
                if (stack.Count == 0)
                {
                    node.NodeID = menu.fatherid.ToString();
                    //node.Text = menu.funname;
                    // node.SingleClickExpand = true;
                    //node.IconCls = "icon-none";
                    
                    //node.Children.AddRange(CreatePaidNodes(roleMenu));
                }
                else
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    //node.Href = menu.funno + ".aspx";
                    node.Leaf = true;
                    node.Children.AddRange(CreatePaidNodes(roleMenu));
                }
                nodes.Add(node);
                 */
                
            }nodes.Add(paid);
            return nodes;
        }
        //角色分配
        private NodeCollection CreateFunTree(string roleid, List<userfun> userFatherFun, List<userfun> userChildernFun)
        {
            NodeCollection nodes = new NodeCollection(false);
            foreach (userfun menu in userFatherFun)
            {
                Node node = new Node();
                //核心
                List<userfun> stack = userChildernFun.FindAll(delegate(userfun fun) { return fun.fatherid == menu.funid; });
                if (stack.Count > 0)
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    // node.SingleClickExpand = true;
                    // node.Checked = ThreeStateBool.False;
                    node.Children.AddRange(CreateFunTree(roleid, stack, userChildernFun));
                }
                else
                {
                    node.NodeID = menu.funid.ToString();
                    node.Text = menu.funname;
                    if (File.Exists(HttpContext.Current.Server.MapPath("/images/Icons/" + menu.funno + ".png")))
                        node.IconCls = "icon-" + menu.funno;
                    else
                        node.IconCls = "icon-none";
                    //  node.Checked = ThreeStateBool.False;
                    node.Leaf = true;
                }
                nodes.Add(node);
            }
            return nodes;
        }
    }
}
