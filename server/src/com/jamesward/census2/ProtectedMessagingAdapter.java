package com.jamesward.census2;

import flex.messaging.services.messaging.Subtopic;
import flex.messaging.services.messaging.adapters.ActionScriptAdapter;

public class ProtectedMessagingAdapter extends ActionScriptAdapter
{

  public boolean allowSubscribe(Subtopic subtopic)
  {
    return !(subtopic.containsSubtopicWildcard());
  }

}