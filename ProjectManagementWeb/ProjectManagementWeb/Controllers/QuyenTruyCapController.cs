using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ProjectManagementWeb.Models;

namespace ProjectManagementWeb.Controllers
{
    public class QuyenTruyCapController : Controller
    {
        private QL_DAEntities db = new QL_DAEntities();

        // GET: QuyenTruyCap
        public ActionResult Index()
        {
            return View(db.QuyenTruyCaps.ToList());
        }

        // GET: QuyenTruyCap/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            QuyenTruyCap quyenTruyCap = db.QuyenTruyCaps.Find(id);
            if (quyenTruyCap == null)
            {
                return HttpNotFound();
            }
            return View(quyenTruyCap);
        }

        // GET: QuyenTruyCap/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: QuyenTruyCap/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "QuyenTruyCapID,DuAnID,NguoiDungID,CapQuyen")] QuyenTruyCap quyenTruyCap)
        {
            if (ModelState.IsValid)
            {
                db.QuyenTruyCaps.Add(quyenTruyCap);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(quyenTruyCap);
        }

        // GET: QuyenTruyCap/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            QuyenTruyCap quyenTruyCap = db.QuyenTruyCaps.Find(id);
            if (quyenTruyCap == null)
            {
                return HttpNotFound();
            }
            return View(quyenTruyCap);
        }

        // POST: QuyenTruyCap/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "QuyenTruyCapID,DuAnID,NguoiDungID,CapQuyen")] QuyenTruyCap quyenTruyCap)
        {
            if (ModelState.IsValid)
            {
                db.Entry(quyenTruyCap).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(quyenTruyCap);
        }

        // GET: QuyenTruyCap/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            QuyenTruyCap quyenTruyCap = db.QuyenTruyCaps.Find(id);
            if (quyenTruyCap == null)
            {
                return HttpNotFound();
            }
            return View(quyenTruyCap);
        }

        // POST: QuyenTruyCap/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            QuyenTruyCap quyenTruyCap = db.QuyenTruyCaps.Find(id);
            db.QuyenTruyCaps.Remove(quyenTruyCap);
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
    }
}
