pragma solidity >=0.5.0 <0.6.0;
 library CrowdStructure
 {
   enum   Contribution{Owner, Consultatnt, Skilled, Investor }
   struct  MemberData {


   string firstName;
   string lastName;
   //string idNo;
   //address admin;
   //string skills;
   string email;
   //string phonNo;
   //string website;
   //string nationality;
   //string country;
   //string city;
   //string addressLine;
   }
   struct ProjectMember
   {
     address adr;
     MemberData data;
     Contribution cont;

   }
   /// Project Modelling
   struct Project
   {

    string projectDiscrption;
    string projectName;
    mapping (address=> ProjectMember) staff;
   }
   struct OwnerProjects
   {
     uint count;
     mapping (uint=>uint) idToProject;

   }


 }
