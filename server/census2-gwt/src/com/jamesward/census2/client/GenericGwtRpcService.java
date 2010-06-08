package com.jamesward.census2.client;

import java.util.List;

import com.google.gwt.user.client.rpc.RemoteService;

/**
 * The client side stub for the RPC service.
 */
public interface GenericGwtRpcService<D> extends RemoteService {
	
    List<D> fetch (Integer startRow, Integer endRow, String sortBy);

    D add (D data);

    D update (D data);

    void remove (D data);
	
}
