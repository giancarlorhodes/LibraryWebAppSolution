﻿using LibraryBusinessLogicLayer;
using LibraryCommon;
using LibraryWebApp.Common;
using LibraryWebApp.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LibraryWebApp.Controllers
{
    public class HomeController : BaseController
    {

        // fields
       
        // properties

        // constuctors
      

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        // Register GET
        [HttpGet]
        public ActionResult Register()
        {
            // this will create the empty form

            UserModel model = new UserModel();

            // 1. collect the information the the user
            ViewBag.Message = "Register page.";
            return View(model);

        }

        [HttpPost]
        public ActionResult Register(UserModel inModel)
        {

        
            // 2. valididate the fields have the correct data otherwise (if) send error to user and have
            // them redo the input 
            // data annotations for validation in MVC

            // valid state, validation passed
            if (ModelState.IsValid)
            {
                // 3. send the input down to the database and check for duplicate username

                // 3.a create new bll object
                UserOperationsBLL _userOperationsBLL = new UserOperationsBLL(base.Connection);

                // 3.b need to convert UserModel object to User object
                User _user = Mapper.UserModelToUser(inModel);

                // 3.c pass the user object down to bll layer
                Result _result = _userOperationsBLL.RegisterUser(_user);

                inModel.DialogMessage = _result.Message;
                inModel.DialogMessageType = _result.Type.ToString();

                return View(inModel);
            }
            // validation failed, have the user redo the form
            else
            {
                
                return View(inModel);

            }
          
        }


    }
}