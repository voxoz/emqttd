-module(emqttd_kvs).
-include_lib("kvs/include/metainfo.hrl").
-include("emqttd.hrl").
-compile(export_all).

metainfo() ->   #schema{name=kvs,tables= tables() }.
tables()   -> [ #table{name=mqtt_subscription, fields=record_info(fields,mqtt_subscription)},
                #table{name=mqtt_subproperty,  fields=record_info(fields,mqtt_subproperty)},
                #table{name=mqtt_subscriber,   fields=record_info(fields, mqtt_subscriber)}
              ].
