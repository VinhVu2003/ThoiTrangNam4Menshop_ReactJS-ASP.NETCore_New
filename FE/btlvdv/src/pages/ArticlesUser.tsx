import React, { useEffect, useState } from "react";
import { Pagination } from "antd";
import { Link } from "react-router-dom";
import ScrollToTopButton from "../constant/ScrollToTopButton";
import { getAllArticles } from "../services/Articles";
import dayjs from "dayjs";
import "./ArticlesUser.css";

interface Article {
  baiVietID: number;
  tieuDe: string;
  noiDung: string;
  ngayTao: string;
  taiKhoanID: number;
}

const ArticlesUser = () => {
  const [articles, setArticles] = useState<Article[]>([]);
  const [selectedArticle, setSelectedArticle] = useState<Article | null>(null);

  useEffect(() => {
    loadArticles();
  }, []);

  const loadArticles = async () => {
    try {
      const response = await getAllArticles();
      // Sort articles by creation date (oldest first)
      const sortedArticles = response.sort((a: Article, b: Article) =>
        dayjs(a.ngayTao).valueOf() - dayjs(b.ngayTao).valueOf()
      );
      setArticles(sortedArticles);
      if (sortedArticles.length > 0) {
        setSelectedArticle(sortedArticles[0]); // Select the first article (oldest) by default
      }
    } catch (error) {
      console.error("Error fetching articles:", error);
    }
  };

  const handleTitleClick = (article: Article) => {
    setSelectedArticle(article);
  };

  return (
    <>
      <ScrollToTopButton />
      <div className="cat_botom-head">
        <ul>
          <li>
            <a href="/">Trang chủ &nbsp; / &nbsp;</a>
          </li>
          <li>
            <a href="/articles">Bài viết</a>
          </li>
        </ul>
      </div>

      <div className="cat_bottom">
        <div className="cat_botom-left">
          <h1>Bài viết</h1>
        </div>
      </div>

      <div className="articles-page-container">
        <div className="article-content-container">
          {selectedArticle ? (
            <div className="article-card">
              <div className="article-header">
                {/* <h2>{selectedArticle.tieuDe}</h2> */}
              </div>
              <div
                className="article-content"
                dangerouslySetInnerHTML={{ __html: selectedArticle.noiDung }}
              />
            </div>
          ) : (
            <div className="no-articles-message" style={{ paddingTop: "20px" }}>
              Chọn một bài viết từ danh sách bên phải để xem nội dung.
            </div>
          )}
        </div>

        <div className="articles-sidebar">
        
          <div>
            <span></span>
            <h2>4MEN™</h2>
          </div>
          
          <ul>
            {articles.map((article) => (
              <li
                key={article.baiVietID}
                onClick={() => handleTitleClick(article)}
                className={selectedArticle?.baiVietID === article.baiVietID ? 'active' : ''}
              >
                <a>
                  {article.tieuDe}
                </a>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </>
  );
};

export default ArticlesUser;
