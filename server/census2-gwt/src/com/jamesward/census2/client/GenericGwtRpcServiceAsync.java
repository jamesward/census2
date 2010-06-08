package com.jamesward.census2.client;

import java.util.List;

import com.google.gwt.user.client.rpc.AsyncCallback;

public interface GenericGwtRpcServiceAsync<D> {

	void add(D data,
			AsyncCallback<D> callback);

	void fetch(Integer startRow, Integer endRow, String sortBy, AsyncCallback<List<D>> callback);

	void remove(D data, AsyncCallback<Void> callback);

	void update(D data,
			AsyncCallback<D> callback);

}
