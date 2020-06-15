//
//  Constants.swift
//  ShowTalent
//
//  Created by apple on 9/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    
    static let K_baseUrl = "http://thcoreapi.maraekat.com/api/v1"
    static let registerUrl = "/Security/Register"
    static let resetPass = "/Security/ReSetPassword"
    static let verifyNumber = "/Security/VerifyPhoneNumber"
    static let elogin  = "/Security/Login"
    static let forGotPassUrl = "/Security/ForgotPassword"
    static let forgotpassemail = "/Security/ForgotPasswordByEmail"
    static let mlogin = "/Security/LoginByPhone"
    static let mloginwpassword = "/Security/LoginByPhoneWithPassword"
    static let guestlogin = "/Security/GuestLogin"
    static let addProf = "/ProfileService/AddIndvProfileAsync"
    static let getCategory = "/Category/Get"
                           //  "/Category/Get"
    
    static let dashboardfeed = "/Dashboard/DashboardFeed"
    static let freshcategories = "/Category/Get"
    
    static let chooseCat = "/Category/AddUserCategoryChoice"
    static let getUserCat = "/Category/GetUserCategoryChoice"
    static let imageUploadurl = "/Post/NewPost"
    static let profiledata = "/ProfileService/Profile/"
    
    static let activitydata = "/Feed/ActivityFeed/"
    static let postLike = "/Post/Like"
    static let postCOmment = "/Contest/PostNewComment"
    static let delComment = "/Contest/DeletePostComment"
    static let editComment = "/Contest/EditComment"
    static let categorywisecomment = "/Post/CommentsActivityWise"
    static let nestedcomment = "/Contest/AddNestedComment"
    
    static let actfeedbyid = "/Feed/ActivityFeedById"
    
    static let getallgroupmaster = "/BelongGroupMaster/GetAllGroupMaster"
    static let creategroup = "/Groups/CreateGroup"
    static let profile = "/ProfileService/Profile/"
    static let uploadprofileimage = "/ProfileService/UpdateProfileImage"
    static let editprofile = "/ProfileService/UpdateIndvProfile"
    
    static let updategroupicon = "/Groups/UpdateGroupIcon"
    static let grouppost = "/Groups/NewGroupPost"
    static let getmygroups = "/Groups/GetGroups"
    static let addpeople = "/Groups/InviteMember"
    static let getallmembers = "/Groups/GetAllMember"
    static let groupfeeds = "/Groups/GroupFeeds"
    static let getjoinedgroups = "/Groups/JoinedGroup"
    static let leavegroup = "/Groups/LeaveGroup"
    
    static let uploadcontacts = "/SyncProvider/SyncContact"
    static let getcontacts = "/SyncProvider/GetContact"
    
    static let fetchfurthergroupinfo = "/Groups/GetGroupById"
    static let sharethiscontest = "/Groups/ShareContest"
    
    static let shareamonggroups = "/Groups/ShareContestInSelectedGroup"
    static let groupdashboard = "/Groups/Dashboard"

    
    static let getprerequisitecontests = "/Contest/PrerequisiteContest"
    static let createcontest = "/Contest/CreateContest"
    
    static let addjury = "/Contest/AddJury"
    static let updatejury = "/Contest/UpdateJury"
    static let addparticipants = "/Contest/AddParticipents"
    static let getevents = "/Contest/GetContest"
    static let getparticularevent = "/Contest/GetContestById"
    static let joinrequest = "/Contest/JoinRequest"
    static let participatepost = "/Contest/ParticipatePost"
    static let joinedcontests = "/Contest/JoinedContest"
    static let getcontestcategorywise = "/Contest/GetContest"
    static let contestfeeds = "/Contest/ContestFeed"
    static let contestlike = "/Contest/Like"
    static let addcontestimage = "/Contest/AddContestImage"
    static let getthemes = "/Contest/GetFilters"
    static let addwinner = "/Contest/AddWinner"
    static let iamjury = "/Contest/ImJury"
    static let updatecontest = "/Contest/UpdateContest"
    static let geteventsbygroup = "/Contest/GetContestByGroupId"
    static let leavecontest = "/Contest/LeaveDeleteMember"
    static let recommendedcontests = "/Contest/GetNearByContest"
   // static let newprofiledata = "/ProfileService/Profile/{userid},{activityType}
    static let contestdashboard = "/Contest/Dashboard"
    static let selfjury = "/Contest/SelfJury"
    static let juryseen = "/Contest/UpdateJurySeen"
    static let allpromotions = "/Promostion/Getpromotion"
    
    static let alllanguages = "/Language/GetAllLanguages"
    static let alleventsfetch = "/EventPublisher/GetEvents"
    static let bookevent = "/EventPublisher/BookEvent"
    static let getbookedevents = "/EventPublisher/GetEventBookingList"
    
    static let searchmembers = "/SearchMember/SearchMembers"
   
    
    static let fetchreviews = "/Contest/GetPostReviewList"
    static let editreview = "/Contest/EditPostReviewList"
    static let postreview = "/Contest/AddPostReview"
    static let publishunpublish = "/Contest/PublishUnpublish"
    static let deletecontest = "/Contest/DeleteContest"
    
    static let getusercategories = "/Category/GetUserCategoryChoice"
    static let updatecategorychoice = "/Category/UpdateUserCategoryChoice"
    
    
    static let coinsledger = "/CoinSystem/EarnCoinList"
    
    static let getnotifications = "/PushNotification/GetNotification" 
    
  //  /api/v{version}/Category/GetUserCategoryChoice
    static let blueColor = UIColor.init(red: 102.0/255, green: 178.0/255, blue: 255.0/255, alpha: 1)
    
    static let nblueclr = UIColor(red: 67.0/255, green: 75.0/255, blue: 255.0/255, alpha: 1.0)
        
    
    static func regularfonts(fontss : Int) -> UIFont
        
    {//NeusaNextStd-Regular
        return UIFont(name: "NeusaNextStd-Regular", size: CGFloat(fontss))!
      //  return UIFont.systemFont(ofSize: CGFloat(fontss))
    }
       // 67 75 255
    
}





