/*
  Copyright (c) 2022 ZTE Corporation.
  All Rights Reserved.
  Confidential and Proprietary - ZTE Corporation.
*/

UPDATE qcril_properties_table SET def_val="true" WHERE property="persist.vendor.radio.redir_party_num";
UPDATE qcril_properties_table SET def_val="0" WHERE property="persist.vendor.radio.poweron_opt";
UPDATE qcril_properties_table SET def_val="1" WHERE property="persist.vendor.radio.voice_on_lte";
UPDATE qcril_properties_table SET def_val="30" WHERE property="persist.vendor.radio.mt_sms_ack";
UPDATE qcril_properties_table SET def_val="0" WHERE property="persist.vendor.radio.bar_fake_gcell";
