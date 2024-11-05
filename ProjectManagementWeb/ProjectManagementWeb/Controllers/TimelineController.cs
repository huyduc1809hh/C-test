    using ProjectManagementWeb.Models;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;

    namespace ProjectManagementWeb.Controllers
    {
        public class TimelineController : Controller
        {
        private DBQLDuAnEntities _database = new DBQLDuAnEntities();

        public ActionResult Index()
        {
            // Lấy tất cả dự án từ cơ sở dữ liệu
            var duAnList = _database.DuAns.ToList();
            return View(duAnList);
        }

        public JsonResult GetDuAnTimeline(int duAnID)
        {
            var duAn = _database.DuAns.FirstOrDefault(d => d.DuAnID == duAnID);
            if (duAn == null)
            {
                return Json(new { success = false, message = "Dự án không tồn tại." }, JsonRequestBehavior.AllowGet);
            }

            var timelineData = new
            {
                NgayBatDau = String.Format("/Date({0})/", ((DateTimeOffset)duAn.NgayBatDau).ToUnixTimeMilliseconds()),
                NgayKetThuc = String.Format("/Date({0})/", ((DateTimeOffset)duAn.NgayKetThuc).ToUnixTimeMilliseconds()),
                MoTa = duAn.MoTa
            };

            return Json(new { success = true, data = timelineData }, JsonRequestBehavior.AllowGet);
        }
    }
    }