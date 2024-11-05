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
    public class DuAnController : Controller
    {
        private QL_DAEntities db = new QL_DAEntities();

        // GET: DuAn
        public ActionResult Index()
        {
            return View(db.DuAns.ToList());
        }

        // GET: DuAn/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DuAn duAn = db.DuAns.Find(id);
            if (duAn == null)
            {
                return HttpNotFound();
            }
            return View(duAn);
        }

        // GET: DuAn/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: DuAn/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "DuAnID,MoTa,NgayBatDau,NgayKetThuc,NganSach")] DuAn duAn)
        {
            if (ModelState.IsValid)
            {
                db.DuAns.Add(duAn);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(duAn);
        }

        // GET: DuAn/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DuAn duAn = db.DuAns.Find(id);
            if (duAn == null)
            {
                return HttpNotFound();
            }
            return View(duAn);
        }

        // POST: DuAn/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "DuAnID,MoTa,NgayBatDau,NgayKetThuc,NganSach")] DuAn duAn)
        {
            if (ModelState.IsValid)
            {
                db.Entry(duAn).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(duAn);
        }

        // GET: DuAn/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DuAn duAn = db.DuAns.Find(id);
            if (duAn == null)
            {
                return HttpNotFound();
            }
            return View(duAn);
        }

        // POST: DuAn/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DuAn duAn = db.DuAns.Find(id);
            db.DuAns.Remove(duAn);
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
