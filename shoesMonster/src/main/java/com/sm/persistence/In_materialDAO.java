package com.sm.persistence;

import java.util.List;

import com.sm.domain.In_materialVO;

public interface In_materialDAO {

	public List<In_materialVO>  readBoardListAll() throws Exception;
}
