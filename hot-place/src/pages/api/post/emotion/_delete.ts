import { NextApiRequest, NextApiResponse } from "next"
import { getServerSession } from "next-auth"
import { authOptions } from "../../auth/[...nextauth]"
import prisma from "../../../../../prisma/prisma_client"

interface ResponseProps {
    message: string
}

export default async function DELETE(req: NextApiRequest, res: NextApiResponse<ResponseProps>) {

    try {
        // 로그인 여부 검사
        const session = await getServerSession(req, res, authOptions)
        if (!session) {
            res.status(401).json({ message: '인증되지 않은 사용자입니다' })
            return
        }
        const userId = session.user.id

        // 좋아요 조회
        const postId = req.query.postId as string
        const emotion = await prisma.emotion.findUniqueOrThrow({
            where: {
                postId_userId: {
                    postId, userId
                }
            }
        })

        // 권한 체크
        if (emotion.userId !== userId) {
            res.status(403).json({ message: 'forbidden request for delete emotion' })
            return
        }

        // 삭제
        await prisma.emotion.delete({
            where: {
                postId_userId: {
                    postId, userId
                }
            },
        })

        res.status(200).json({ message: "success to delete like" })

    } catch (err) {
        // 에러처리
        res.status(500).json({ message: "internal server error" })
    }
}