package kr.co.domain;

public class AttDTO {

	private int attNum;
	private int num;
	private String attPath;
	
	public AttDTO() {
		// TODO Auto-generated constructor stub
	}

	public AttDTO(int attNum, int num, String attPath) {
		super();
		this.attNum = attNum;
		this.num = num;
		this.attPath = attPath;
	}

	public int getAttNum() {
		return attNum;
	}

	public void setAttNum(int attNum) {
		this.attNum = attNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getAttPath() {
		return attPath;
	}

	public void setAttPath(String attPath) {
		this.attPath = attPath;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + attNum;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AttDTO other = (AttDTO) obj;
		if (attNum != other.attNum)
			return false;
		return true;
	}
	
}