-module(emqttd_kvs).
-include_lib("kvs/include/metainfo.hrl").
-include("emqttd.hrl").
-export([metainfo/0,tables/0]).

metainfo() ->   #schema{name=kvs,tables= tables() }.
tables()   -> [ #table{name=mqtt_subproperty,
                       fields=record_info(fields,mqtt_subproperty),
                       copy_type=disc_copies, type=set},

                #table{name=mqtt_subscription,
                       fields=record_info(fields,mqtt_subscription),
                       copy_type=disc_copies, type=bag},

                #table{name=mqtt_subscriber,
                       fields=record_info(fields,mqtt_subscriber),
                       copy_type=disc_copies, type=bag}
              ].
