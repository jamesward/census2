package com.jamesward.census2.client;

import com.google.gwt.user.client.rpc.RemoteServiceRelativePath;
import com.jamesward.census2.shared.CensusEntryVO;

/**
 * The client side stub for the RPC service.
 */
@RemoteServiceRelativePath("getElements")
public interface CensusGWTService extends GenericGwtRpcService<CensusEntryVO> {
	
}