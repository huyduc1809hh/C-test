using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProjectManagementWeb.Models;

namespace ProjectManagementWeb.Controllers
{
    public class BudgetsController : Controller
    {
        DBQLDuAnEntities database = new DBQLDuAnEntities();

        // GET: Budgets
        public ActionResult Index()
        {
            return View(database.NganSaches.ToList());
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(NganSach nganSach)

        {
            database.NganSaches.Add(nganSach);
            database.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Details(int id)
        {
            return View(database.NganSaches.Where(s => s.NganSachID == id).FirstOrDefault());
        }
        public ActionResult Edit (int id )
        {
            return View(database.NganSaches.Where(s => s.NganSachID == id).FirstOrDefault());
        }
        [HttpPost]
        public ActionResult Edit(int id , NganSach nganSach)
        {
            database.Entry(nganSach).State = System.Data.Entity.EntityState.Modified;
            database.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            return View(database.NganSaches.Where(s => s.NganSachID == id).FirstOrDefault());
        }
        [HttpPost]
        public ActionResult Delete(int id, NganSach nganSach)
        {
            nganSach = database.NganSaches.Where(s => s.NganSachID == id).FirstOrDefault();
            database.NganSaches.Remove(nganSach);
            database.SaveChanges();
            return RedirectToAction("Index");
        }
    }


    
}