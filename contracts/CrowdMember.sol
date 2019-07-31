pragma solidity >=0.5.0 <0.6.0;
/// @title A simulator for crowd sourcing and funding members and projects
/// @author Fatin Alki
/// @notice You can use this contract for only the most basic simulation
/// @dev All function calls are currently implemented without side effects
pragma experimental ABIEncoderV2;
import "./CrowdStructure.sol";
import "./Project.sol";
/** @title Crowd Member  */
 contract CrowdMember
 {






//State variables

// mapping address to CrowdMember
mapping (address=>CrowdStructure.MemberData) private members;
mapping (address=>bool) private enrolledMembers;
mapping (uint=>CrowdStructure.Project)private projects ;
mapping (address=>CrowdStructure.OwnerProjects) private ownerToProjects;
//setting a counter of al members
uint public membersCount ;
//bytes32 public txID ;
uint  indexProjects;


////*events*///
event LogEnrolled(address indexed accountAddress);
//Constructor used to intialize state variable
constructor() public
  {
    indexProjects=0;
    membersCount=0;

  }

  /** @notice This function called by frontend to pass the parameters and register new memebr
    * @dev Storing  member data in enrolled and members .
    * @param _firstNameMember First Name of the member.
    * @param _lastNameMember Last name of the member .
    * @return s The calculated surface.
    */

function storeMemebr(string memory _firstNameMember,string memory _lastNameMember, string memory _emailMember) public returns(bool)
{

if(enrolledMembers[msg.sender]==false)
{
  CrowdStructure.MemberData memory _member;
  _member.firstName=_firstNameMember;
  _member.lastName= _lastNameMember;
  //member.skills=_skillsMember ;
  _member.email=_emailMember;
  //member.phonNo= _phonNoMember;
  //member.nationality=_nationalityMember;
  members[msg.sender]=_member;
  enrolledMembers[msg.sender]=true;
  membersCount+=1;
  emit LogEnrolled(msg.sender);
}
return enrolledMembers[msg.sender];

//  txID=keccak256(abi.encodePacked(index2,msg.sender));

}
/** @notice This function called by  user interface to get info of specific member
  * @dev Retrieving  member data in enrolled and members lookups.

  * @return Data of msg.sender .
  */


 function  getMember()  public view returns  (CrowdStructure.MemberData memory)
 {

   return (members[msg.sender]);

 }
 /** @notice This function called by  user interface to get info of specific member
   * @return tempCount The counted members of the contracts .
   */

 function getMemeberCount() public view returns (uint tempCount)
 {
    tempCount=membersCount;
    return tempCount;
 }
 /** @notice This function called by  user interface to create a project  of specific member
   * @dev Storing  project data in projects lookup.
   * @dev Storing  project ID in ownerToProjects lookup.
   * @param _discription The disciption of the project.
   *@param _name The name of the project
   * @return prjID The created project ID .
   */


 function createProject(string memory _discription, string memory _name) public returns (uint prjID)
 {

   if (enrolledMembers[msg.sender]==true)
   {
     CrowdStructure.MemberData memory _data= members[msg.sender];
     CrowdStructure.Project memory _prj;
     _prj.projectName=_name;
     _prj.projectDiscrption=_discription;
     CrowdProject prj= (new CrowdProject());
     indexProjects++;
     projects[indexProjects]=_prj;
     projects[indexProjects].staff[msg.sender]= CrowdStructure.ProjectMember ({adr:msg.sender,data:_data,cont:CrowdStructure.Contribution.Owner}) ;
     ownerToProjects[msg.sender].count ++;
     uint index = ownerToProjects[msg.sender].count+1;
     ownerToProjects[msg.sender].idToProject[index]=indexProjects;
     prjID=indexProjects;

     //txID=keccak256(abi.encodePacked(index2,msg.sender));
 }
 }

 /** @notice This function called by  user interface to count the no of the projects of a specific member.

   * @return  _count No of the created projects of the sender .
   */

 function retrievNoProject() public view returns (uint _count )
 {
   //uint   _count =ownerToProjects[_address].count;

   //address[] memory _lstProjects;
   //for (uint i=1; i<=_count; i++) {
   //_lstProjects[i]=ownerToProjects[_address].idToProject[i];
 //}
     if (enrolledMembers[msg.sender])
       {
          CrowdStructure.OwnerProjects memory _temp =ownerToProjects[msg.sender];
         _count= _temp.count;
        }
 }

}
