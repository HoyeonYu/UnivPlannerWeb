package lms;

import java.io.*;
import java.net.Socket;
import java.sql.*;
import java.util.Vector;

public class LmsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
    private String idText, pwText;
	private int schoolIdx = 0;
    private Boolean isLoginSuccess = false;
    Vector<String> lectureNameVec = new Vector<String>();
    Vector<String> lecturePercentVec = new Vector<String>();
    Vector<String> lectureAssignmentVec = new Vector<String>();
	
	public LmsDAO() {
		try {
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//�α��� ����
	public int login(String userID, String userPassword) {
		try {
			idText = userID;
			pwText = userPassword;
			
			ClientThread thread = new ClientThread();
			thread.run();
			
			if (isLoginSuccess) {
				return 1; //�α��� ����
			}
			
			return -1; //�α��� ����
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; //����
	}
	
	public class ClientThread extends Thread {
        public void run() {
            String host = "220.69.171.222";
            int port = 38497;

            try {
                Socket socket = new Socket(host, port);

                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
                
                out.println(schoolIdx + "\n" + idText + "\n" + pwText);
                System.out.println(schoolIdx + "\n" + idText + "\n" + pwText);

                String rev = in.readLine();

                if (rev.equals("Success")) {
                    isLoginSuccess = true;
                    String lectureNameList = "";

                    String userName = in.readLine();	//outer Lecture number

                    String totalLectureNumStr = in.readLine();	//outer Lecture number
                    System.out.println("total Lecture Num" + totalLectureNumStr);
                    
                    int totalLectureNum = Integer.parseInt(totalLectureNumStr);

                    String realTotalLectureNumStr = in.readLine();	//outer Lecture number
                    System.out.println("real total Lecture Num" + realTotalLectureNumStr);
                    int realTotalLectureNum = Integer.parseInt(realTotalLectureNumStr);

                    for (int i = 0; i < realTotalLectureNum; i++) {
                        String lectureTitle = in.readLine();	// outer lecture title
                        
                        if (lectureTitle.equals("LectureDone")) {   // if �����԰���, break
                            break;
                        }

                        lectureNameList += (lectureTitle + "\n");
                        lectureNameVec.add(lectureTitle);

                        System.out.println("outer lecture title" + lectureTitle);

                        String innerLectureNumStr = in.readLine();	// inner lecture number
                        System.out.println("inner lecture num: " + innerLectureNumStr);
                        int innerLectureNum = Integer.parseInt(innerLectureNumStr);

                        String innerLecturePercentStr = "";
                        innerLecturePercentStr += (innerLectureNum + "\n");

                        if (innerLectureNum > 0) {
                            String innerLecturePeriod = in.readLine();	// inner lecture number
                            innerLecturePercentStr += (innerLecturePeriod + "\n");
                            System.out.println("inner lecture period: " + innerLecturePeriod);
                        }

                        for (int j = 0; j < innerLectureNum; j++) {
                            String innerLecturePer = in.readLine();	// inner lecture percentage text
                            innerLecturePercentStr += (innerLecturePer + " ");
                            System.out.println("inner lecture percent: " + innerLecturePer);
                        }

                        String innerAssignmentStr = "";
                        String innerAssignmentNumStr = in.readLine();	// inner lecture number
                        System.out.println("total assignment num: " + innerAssignmentNumStr);

                        if (!innerAssignmentNumStr.equals("AssignmentDone")) {
                            int innerAssignmentNum = Integer.parseInt(innerAssignmentNumStr);
                            int realAssignNum = 0;

                            for (int j = 0; j < innerAssignmentNum; j++) {
                                String assignmentName = in.readLine();	// inner lecture percentage text

                                if (assignmentName.equals("AssignmentDone")) {
                                    break;
                                }

                                innerAssignmentStr += (assignmentName + "\n");
                                System.out.println("inner assign name:" + assignmentName);

                                String isAssignmentSubmitted = in.readLine();	// inner lecture percentage text
                                innerAssignmentStr += (isAssignmentSubmitted + "\n");
                                System.out.println("inner assign submitted:" + isAssignmentSubmitted);

                                String assignmentPeriod = in.readLine();	// inner lecture percentage text
                                innerAssignmentStr += (assignmentPeriod + "\n");
                                System.out.println("inner assign period:" + assignmentPeriod);
                                realAssignNum++;
                            }

                            innerAssignmentStr = realAssignNum + "\n" + innerAssignmentStr;
                        }

                        else {
                            innerAssignmentStr += "0\n";
                        }

                        lecturePercentVec.add(innerLecturePercentStr);
                        lectureAssignmentVec.add(innerAssignmentStr);
                    }

                    String realLectureNumStr = in.readLine();	// inner lecture number
                    System.out.println("Real Lecture Num" + realLectureNumStr);
                    System.out.println("lectureNameVec" + lectureNameVec.size() + "");
                    System.out.println("lecturePercentVec" + lecturePercentVec.size() + "");
                    System.out.println("lectureAssignmentVec" + lectureAssignmentVec.size() + "");
                }

                else {
                    isLoginSuccess = false;
                }
            }

            catch (Exception e) {
                isLoginSuccess = false;
                System.out.println("sck" + "fail");
                e.printStackTrace();
            }
        }
    }
}
