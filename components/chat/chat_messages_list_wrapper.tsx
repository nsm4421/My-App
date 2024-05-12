import getSupabaseServer from "@/lib/supabase/server";
import { Suspense } from "react";
import ChatMessageList from "./chat_message_list";
import InitMessages from "@/lib/store/message/init_messages";

export default async function ChatMessageListWraaper() {
  const supabase = getSupabaseServer();

  const { data } = await supabase.from("messages").select("*,user:users(*)")
  .range(0, 20).order("created_at", {ascending:false})
  ;

  return (
    <Suspense fallback={"로딩중입니다..."}>
      <ChatMessageList/>
      <InitMessages messages={data?.reverse() || []} />
    </Suspense>
  );
}
