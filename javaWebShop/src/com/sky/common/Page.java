package com.sky.common;

public class Page {
	private int recordCount = 1;// 总的记录数
	private int pageSize = 1; // 每页显示的记录数
	private int showPage = 1; // 设置欲显示的页码数
	private int count = 1; // 分页之后的总页数

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public int getRecordCount() {
		return this.recordCount;
	}

	public void setCount(int recordCount, int pageSize) {
		this.recordCount = recordCount;
		this.pageSize = pageSize;
		int n = (this.recordCount % this.pageSize) == 0 ? (this.recordCount / this.pageSize)
				: (this.recordCount / this.pageSize + 1);
		this.count = n;
	}

	public void setShowPage(int showPage) {
		this.showPage = showPage;
	}

	public int getShowPage() {
		return this.showPage;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public boolean getIsFirst() {
		if (showPage <= 1)
			return true;
		else
			return false;
	}

	public boolean getIsLast() {
		if (showPage >= count)
			return true;
		else
			return false;
	}
}
