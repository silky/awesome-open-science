#!/usr/bin/env stack
-- stack --resolver lts-5 --install-ghc runghc --package pandoc

import Text.Pandoc
import Text.Pandoc.Walk (walk)
import Data.List        (sort)

sortBulletList :: Block -> Block
sortBulletList (BulletList xs) = BulletList (sort xs)
sortBulletList x = x

readDoc :: String -> Pandoc
readDoc s = case (readMarkdown def s) of
               Left  e -> error $ "Error: " ++ show (e)
               Right p -> p

writeDoc :: Pandoc -> String
writeDoc = writeMarkdown def

main :: IO ()
main = interact (writeDoc . walk sortBulletList . readDoc)
