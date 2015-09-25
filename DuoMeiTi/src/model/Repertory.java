package model;

import javax.persistence.*;

@Entity
public class Repertory {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int rtId;
	
	@Column(length=50)
	public String rtType;
	
	@Column(length=200)
	public String rtNumber;
	
	@Column(length=200)
	public String rtVersion;
	
	@Column(length=200)
	public String rtFactorynum;
	
	@Column(length=200)
	public String rtDevice;
	
	@Column(length=10)
	public String rtDeviceStatus;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn
	public Classroom classroom;

	public int getRtId() {
		return rtId;
	}

	public void setRtId(int rtId) {
		this.rtId = rtId;
	}

	public String getRtType() {
		return rtType;
	}

	public void setRtType(String rtType) {
		this.rtType = rtType;
	}

	public String getRtNumber() {
		return rtNumber;
	}

	public void setRtNumber(String rtNumber) {
		this.rtNumber = rtNumber;
	}

	public String getRtVersion() {
		return rtVersion;
	}

	public void setRtVersion(String rtVersion) {
		this.rtVersion = rtVersion;
	}

	public String getRtFactorynum() {
		return rtFactorynum;
	}

	public void setRtFactorynum(String rtFactorynum) {
		this.rtFactorynum = rtFactorynum;
	}
	
	public String getRtDevice() {
		return rtDevice;
	}

	public void setRtDevice(String rtDevice) {
System.out.println("set");
		this.rtDevice = rtDevice;
	}

	public Classroom getClassroom() {
		return classroom;
	}

	public void setClassroom(Classroom classroom) {
		this.classroom = classroom;
	}
	
	
	public String getRtDeviceStatus() {
		return rtDeviceStatus;
	}

	public void setRtDeviceStatus(String rtDeviceStatus) {
		this.rtDeviceStatus = rtDeviceStatus;
	}

	public String toString() {
		return this.rtType + "," + this.rtNumber;
	}
}
