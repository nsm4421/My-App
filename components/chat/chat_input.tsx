"use client";

import { ChangeEvent, useState } from "react";
import { Input } from "../ui/input";
import getSupbaseBrowser from "@/lib/supabase/browser";
import { Toaster, toast } from "sonner";
import { Button } from "../ui/button";
import { IMessage, useMessage } from "@/lib/store/message/message";
import { v4 } from "uuid";
import { useUser } from "@/lib/store/user/user";

export default function ChatInput() {
  const maxLength = 1000;
  const supabsae = getSupbaseBrowser();
  const { basicUser } = useUser();
  const { addMessage } = useMessage();

  const [content, setContent] = useState<string>("");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleContent = (e: ChangeEvent<HTMLInputElement>) => {
    const text = e.target.value;
    if (text.length <= maxLength) {
      setContent(e.target.value);
    }
  };

  const handleSendMessage = async () => {
    // validate
    if (content.trim() === "") {
      return;
    }
    setIsLoading(true);
    // 메세지 보내기
    try {
      const newMessage: IMessage = {
        id: v4(),
        content: content.trim(),
        created_at: new Date().toISOString(),
        sender: basicUser,
        removed_at: null,
      };

      // 서버에 메세지 저장
      const { error } = await supabsae.from("messages").insert({
        content,
      });

      if (error) {
        toast.error(error.message);
        return;
      }

      // 전역 상태변수 업데이트
      addMessage(newMessage);
      setContent("");
    } catch (err) {
      toast.error("메세지 전송 실패");
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div>
      <div className="flex flex-row gap-2">
        <Input
          placeholder="메세지를 입력해주세요"
          value={content}
          onChange={handleContent}
        />
        <Button onClick={handleSendMessage} disabled={isLoading}>
          Send
        </Button>
      </div>
      <Toaster position="top-center" />
    </div>
  );
}
