package kr.co.domain;

public class SelectDTO {
	
	private String option;
	private String val;
	private String path;
	
	public SelectDTO() {
		// TODO Auto-generated constructor stub
	}

	public SelectDTO(String option, String val) {
		super();
		this.option = option;
		this.val = val;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((option == null) ? 0 : option.hashCode());
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
		SelectDTO other = (SelectDTO) obj;
		if (option == null) {
			if (other.option != null)
				return false;
		} else if (!option.equals(other.option))
			return false;
		return true;
	}
	
}
