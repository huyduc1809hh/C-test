using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DinkToPdf;
using iTextSharp.text.pdf;
using iTextSharp.text;
using ProjectManagementWeb.Models;
using System.Dynamic;

namespace ProjectManagementWeb.Controllers
{
    public class NhiemVuController : Controller
    {
        private QL_DAEntities db = new QL_DAEntities();

        // GET: NhiemVu
        public ActionResult Index()
        {
            var list = db.NhiemVus.OrderByDescending(m=>m.NgayTao).ToList();
            return View("Index", list);
        }

        // GET: NhiemVu/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            NhiemVu nhiemVu = db.NhiemVus.Find(id);
            if (nhiemVu == null)
            {
                return HttpNotFound();
            }
            return View(nhiemVu);
        }

        // GET: NhiemVu/Create
        public ActionResult Create()
        {
            var nhiemvu = new NhiemVu
            {
                NgayTao = DateTime.Now
            };
            ViewBag.DuAn = new SelectList(db.DuAns, "DuAnID", "MoTa");
            ViewBag.NguoiDung = new SelectList(db.NguoiDungs, "NguoiDungID", "HoTen");
            return View(nhiemvu);
        }

        // POST: NhiemVu/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "NhiemVuID,DuAnID,NguoiDuocGiaoID,TenNhiemVu,MoTa,TrangThai,NgayTao,HanHoanThanh")] NhiemVu nhiemVu)
        {
            if (ModelState.IsValid)
            {
                db.NhiemVus.Add(nhiemVu);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            db.Entry(nhiemVu).State = EntityState.Modified;
            ViewBag.DuAn = new SelectList(db.DuAns, "DuAnID", "MoTa", nhiemVu.DuAnID);
            ViewBag.NguoiDung = new SelectList(db.NguoiDungs, "NguoiDungID", "HoTen", nhiemVu.NguoiDuocGiaoID);
            return View(nhiemVu);
        }

        // GET: NhiemVu/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            NhiemVu nhiemVu = db.NhiemVus.Find(id);
            if (nhiemVu == null)
            {
                return HttpNotFound();
            }
            return View(nhiemVu);
        }

        // POST: NhiemVu/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "NhiemVuID,DuAnID,NguoiDuocGiaoID,TenNhiemVu,MoTa,TrangThai,NgayTao,HanHoanThanh")] NhiemVu nhiemVu)
        {
            if (ModelState.IsValid)
            {
                db.Entry(nhiemVu).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(nhiemVu);
        }

        // GET: NhiemVu/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            NhiemVu nhiemVu = db.NhiemVus.Find(id);
            if (nhiemVu == null)
            {
                return HttpNotFound();
            }
            return View(nhiemVu);
        }

        // POST: NhiemVu/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            NhiemVu nhiemVu = db.NhiemVus.Find(id);
            db.NhiemVus.Remove(nhiemVu);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public ActionResult ExportToPdf()
        {
            var memoryStream = new MemoryStream();
            Document document = new Document();
            PdfWriter.GetInstance(document, memoryStream);
            document.Open();

            document.Add(new Paragraph("Danh sách nhiệm vụ"));
            // Thêm nội dung PDF vào đây
            //Tạo bảng
            PdfPTable table = new PdfPTable(7);
            table.WidthPercentage = 100;
            //Thêm tiêu đề cột
            table.AddCell("ID Dự án");
            table.AddCell("ID Người được giao");
            table.AddCell("Tên nhiệm vụ");
            table.AddCell("Mô tả");
            table.AddCell("Trạng thái");
            table.AddCell("Ngày tạo");
            table.AddCell("Hạn hoàn thành");
            
            //Lấy danh sách NV
            var tasks = db.NhiemVus.ToList();
            foreach (var task in tasks)
            {
                table.AddCell(task.DuAnID.ToString());
                table.AddCell(task.NguoiDuocGiaoID.ToString());
                table.AddCell(task.TenNhiemVu);
                table.AddCell(task.MoTa);
                table.AddCell(task.TrangThai);
                table.AddCell(task.NgayTao?.ToShortDateString() ?? "N/A");
                table.AddCell(task.HanHoanThanh?.ToShortDateString() ?? "N/A");
            }
            document.Add(table);
            document.Close();
            byte[] pdfBytes = memoryStream.ToArray();
            return File(pdfBytes, "application/pdf", "DanhSachNhiemVu.pdf");
        }
        //Lấy danh sách nhiệm vụ theo ID
        public ActionResult UserTasks(int NguoiDungID)
        {
            Session["NguoiDungID"] = NguoiDungID;
            int currentNguoiDungID = (int)Session["NguoiDungID"];
            var result = UserTasks(currentNguoiDungID);
            var tasks = db.NhiemVus
                .Where(m => m.NguoiDuocGiaoID == NguoiDungID)
                .OrderByDescending(m => m.NgayTao) .ToList();
            return View("NhiemVu", tasks);
        }
        //// Action để xử lý đăng nhập
        //public ActionResult Login(UserLoginModel model)
        //{
        //    // Kiểm tra thông tin đăng nhập
        //    var user = db.NguoiDungs.FirstOrDefault(u => u.TaiKhoan == model.TaiKhoan && u.MatKhau == model.MatKhau);
        //    if (user != null)
        //    {
        //        Session["UserId"] = user.NguoiDungID; // Lưu ID người dùng vào session
        //        return RedirectToAction("UserTasks", new { userId = user.NguoiDungID });
        //    }
        //    ModelState.AddModelError("", "Đăng nhập không thành công.");
        //    return View(model);
        //}
        public JsonResult GetLatestTasks(int NguoiDungID)
        {
            Session["NguoiDungID"] = NguoiDungID;
            int currentNguoiDungID = (int)Session["NguoiDungID"];
            var result = GetLatestTasks(currentNguoiDungID);
            var tasks = db.NhiemVus.Where(m => m.NguoiDuocGiaoID == NguoiDungID)
                .OrderByDescending(m => m.NgayTao)
                .Take(5) // Chỉ lấy 5 nhiệm vụ mới nhất
                .Select(m => new
                {
                    m.NhiemVuID,
                    m.TenNhiemVu,
                    m.MoTa,
                    m.NgayTao
                })
                .ToList();

            return Json(tasks, JsonRequestBehavior.AllowGet);
        }
    }
}
