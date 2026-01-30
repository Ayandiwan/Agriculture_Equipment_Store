using System;

namespace Agriculture_Equipment_Store
{
    public partial class logout_coustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         //   Session.Clear();
           // Session.Abandon();
            // ✅ Clear session
            Session.Clear();
            Session.Abandon();

            // ✅ Clear cookies
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            }

            // ✅ Prevent cached back button
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // ✅ Redirect to login page after short delay
            Response.AddHeader("REFRESH", "2;URL=login.aspx");
          //  Response.Redirect("login.aspx");

        }
    }
}
